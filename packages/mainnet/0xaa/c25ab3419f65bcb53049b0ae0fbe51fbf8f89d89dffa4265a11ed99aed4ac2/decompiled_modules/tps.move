module 0xaac25ab3419f65bcb53049b0ae0fbe51fbf8f89d89dffa4265a11ed99aed4ac2::tps {
    struct TPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPS>(arg0, 6, b"TPS", b"TRUMP SUI", b"Make America Great Once Again on SUI !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240919224556_6cc8641bdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

