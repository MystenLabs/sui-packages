module 0x397e499efc2db10f2eedfc50f73cd0e3281e1d80505eee859a10b8f2867953b3::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 6, b"SCF", b"Sui Chicken Fish", b"The most popular meme on Sui Ecosystem, come on make it the big history! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730954077174.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

