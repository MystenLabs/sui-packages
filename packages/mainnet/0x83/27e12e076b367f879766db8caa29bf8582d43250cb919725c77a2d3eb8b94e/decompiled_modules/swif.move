module 0x8327e12e076b367f879766db8caa29bf8582d43250cb919725c77a2d3eb8b94e::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 6, b"SWIF", b"SUI WIF", b"Popular meme Dogwifhat vibes wif frens onchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_2400_53ee4aec49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

