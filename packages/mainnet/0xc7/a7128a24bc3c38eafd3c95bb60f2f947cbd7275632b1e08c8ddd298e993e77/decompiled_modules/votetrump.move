module 0xc7a7128a24bc3c38eafd3c95bb60f2f947cbd7275632b1e08c8ddd298e993e77::votetrump {
    struct VOTETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOTETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOTETRUMP>(arg0, 6, b"voteTrump", b"votetrump", b"Do your part to guarantee we win by more than the Margin of Fraud by casting your vote and taking responsibility for ensuring every Republican and Trump voter in your household casts theirs too.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/71c8_Njfu_F9_L_e3f0810d23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOTETRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOTETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

