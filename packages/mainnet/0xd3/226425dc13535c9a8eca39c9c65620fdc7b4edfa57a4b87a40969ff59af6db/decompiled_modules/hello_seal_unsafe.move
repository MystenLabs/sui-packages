module 0xd3226425dc13535c9a8eca39c9c65620fdc7b4edfa57a4b87a40969ff59af6db::hello_seal_unsafe {
    struct SealedMessage has store, key {
        id: 0x2::object::UID,
        encrypted_message: vector<u8>,
        sender: address,
        recipient: address,
    }

    public entry fun create_message(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SealedMessage{
            id                : 0x2::object::new(arg2),
            encrypted_message : arg0,
            sender            : 0x2::tx_context::sender(arg2),
            recipient         : arg1,
        };
        0x2::transfer::share_object<SealedMessage>(v0);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg2 != @0x0) {
            assert!(v0 == arg1 || v0 == arg2, 0);
        };
    }

    // decompiled from Move bytecode v6
}

