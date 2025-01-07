module 0x6996abc0d1e72bec496c89ef479126e44014210b94df0d2bedcb78405fd7b531::kbw {
    struct KBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBW>(arg0, 6, b"KBW", b"KBW2024", b"born during the kbw2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Wy6ms_Iak_A_Eur8n_ebc7af27f0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

