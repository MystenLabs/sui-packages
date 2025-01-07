module 0xd02d5f258fd6b85d748ffdc51c664a3e621b58b4e773aeb8cfd56c1ed89f9095::flow {
    struct FLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOW>(arg0, 9, b"FLOW", b"FLOW ZEBRA", b"The official mascot of the Flow X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b11be92c1f0a869a0bea2566b05366b1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

