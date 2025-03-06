module 0x8c4d2e91e2a5331e300855359bb8c2362adc432d046edb27ea3a7ce1bb7a0eb7::dmail_mail {
    struct Message has copy, drop {
        sender: address,
        to: 0x1::string::String,
        path: 0x1::string::String,
    }

    struct MailService has store, key {
        id: 0x2::object::UID,
        receiver: address,
        feeAmount: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MailService{
            id        : 0x2::object::new(arg0),
            receiver  : 0x2::tx_context::sender(arg0),
            feeAmount : 1,
        };
        0x2::transfer::share_object<MailService>(v0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun send_mail(arg0: &mut MailService, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.feeAmount, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.receiver);
        let v0 = Message{
            sender : 0x2::tx_context::sender(arg4),
            to     : arg1,
            path   : arg2,
        };
        0x2::event::emit<Message>(v0);
    }

    public entry fun setFeeAmount(arg0: &mut MailService, arg1: &OwnerCap, arg2: u64) {
        arg0.feeAmount = arg2;
    }

    public entry fun setReceiver(arg0: &mut MailService, arg1: &OwnerCap, arg2: address) {
        arg0.receiver = arg2;
    }

    // decompiled from Move bytecode v6
}

