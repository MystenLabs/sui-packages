module 0x898a202a1916b506802128843d3ccaf08f4b2ad8fd29f213b04861e74d1f34c8::swif {
    struct SWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIF>(arg0, 6, b"SWIF", b"DOG WIF SUI", b"Introducing DOG $WIF SUI, the ultimate meme coin on the SUI blockchain! Dont miss out on the paw-some fun as we bring serious humor to crypto, while wagging away the FUD like a pro.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BAC_f6cc3d1c55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

