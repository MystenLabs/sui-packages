module 0x5ed876437d7d38fcc5e8d3b4097a02b3887d9afa28b2bce32d75db6225306c6e::monga {
    struct MONGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONGA>(arg0, 6, b"MONGA", b"MONGA OF THE SUI", b"MONGA, protector of the SUI, half ape half sea beast, only hero of the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Monga_Sui_4e34027ecf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

