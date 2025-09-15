module 0x882dc088a59754de0741baab48c6f6a6b9089f81bf5d75fc4b77ebf56b8dec4::example {
    struct Message has copy, drop {
        msg: 0x1::string::String,
        receiver: address,
        validator_choice: u8,
    }

    struct ValidatorInfo has key {
        id: 0x2::object::UID,
        validators: vector<address>,
    }

    struct ValidatorCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ValidatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ValidatorCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ValidatorInfo{
            id         : 0x2::object::new(arg0),
            validators : 0x1::vector::singleton<address>(0x2::tx_context::sender(arg0)),
        };
        0x2::transfer::share_object<ValidatorInfo>(v1);
    }

    entry fun mint_cap(arg0: &ValidatorCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ValidatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ValidatorCap>(v0, arg1);
    }

    entry fun send_message(arg0: 0x1::string::String, arg1: u8, arg2: &ValidatorInfo, arg3: &0x2::tx_context::TxContext) {
        let v0 = arg2.validators;
        assert!(arg1 < (0x1::vector::length<address>(&v0) as u8), 0);
        let v1 = Message{
            msg              : arg0,
            receiver         : 0x2::tx_context::sender(arg3),
            validator_choice : arg1,
        };
        0x2::event::emit<Message>(v1);
    }

    // decompiled from Move bytecode v6
}

