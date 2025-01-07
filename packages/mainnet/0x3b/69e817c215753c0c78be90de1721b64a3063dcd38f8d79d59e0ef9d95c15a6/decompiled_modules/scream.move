module 0x3b69e817c215753c0c78be90de1721b64a3063dcd38f8d79d59e0ef9d95c15a6::scream {
    struct SCREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCREAM>(arg0, 6, b"SCREAM", b"Scream The Meme", b"Wazzzzzuppppppppppppp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Og_Mrr2_ZD_400x400_f9a0600146.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

