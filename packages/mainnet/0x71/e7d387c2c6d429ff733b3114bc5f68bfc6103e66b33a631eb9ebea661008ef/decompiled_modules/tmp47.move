module 0x71e7d387c2c6d429ff733b3114bc5f68bfc6103e66b33a631eb9ebea661008ef::tmp47 {
    struct TMP47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMP47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMP47>(arg0, 6, b"TMP47", b"Trump 47th", b"Trump's inauguration Jan 20. We will get rich!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_j_bitk_A_p_e2f570395d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMP47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMP47>>(v1);
    }

    // decompiled from Move bytecode v6
}

