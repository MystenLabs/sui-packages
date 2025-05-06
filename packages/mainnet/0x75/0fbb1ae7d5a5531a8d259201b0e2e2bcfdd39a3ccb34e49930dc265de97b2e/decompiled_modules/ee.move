module 0x750fbb1ae7d5a5531a8d259201b0e2e2bcfdd39a3ccb34e49930dc265de97b2e::ee {
    struct EE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EE>(arg0, 9, b"EE", b"WE", b"EV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/726b2bba3606a3013edd01fa26b753beblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

