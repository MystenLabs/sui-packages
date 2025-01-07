module 0x9f6349424c2682ff1913f8acd21dfabad0f45351b3406b82a9bfd408d2359128::olg {
    struct OLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLG>(arg0, 6, b"OLG", b"Our Lady of Quadalupe", b"$OLG Meme token for Queen Mary or Our Lady of Guadalupe.  We are on $SUI Network launching on MovePump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Queen_Mary_ae4fd0b7f0.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

