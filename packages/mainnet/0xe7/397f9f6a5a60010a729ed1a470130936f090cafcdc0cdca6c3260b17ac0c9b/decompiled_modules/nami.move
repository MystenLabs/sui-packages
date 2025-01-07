module 0xe7397f9f6a5a60010a729ed1a470130936f090cafcdc0cdca6c3260b17ac0c9b::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 6, b"NAMI", b"SUINAMI", b"Imagine a world where your crypto journey is as smooth and exhilarating as a perfect wave. With $Suinami, weve eliminated the drag of taxes  a 0/0 tax rate means your tokens are free to ride the gains without any holdbacks. And just like a true tsunami, weve ensured that all liquidity is burnt, locking in your investments security like never before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7395_2_123d3c8b60.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

