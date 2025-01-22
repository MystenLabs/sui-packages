module 0x45e328af592431668f2732f598a10fde1d0fc169a31264e751f0d7ce717d77a0::geni {
    struct GENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENI>(arg0, 9, b"GENI", b"Geni AI", b"Your intelligent gateway to the future of decentralized automation ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/03a0a010c1de32578146e61bd4419077blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

