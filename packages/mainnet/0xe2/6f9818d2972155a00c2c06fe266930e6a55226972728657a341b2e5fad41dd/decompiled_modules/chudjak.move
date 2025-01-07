module 0xe26f9818d2972155a00c2c06fe266930e6a55226972728657a341b2e5fad41dd::chudjak {
    struct CHUDJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUDJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUDJAK>(arg0, 6, b"CHUDJAK", b"Chudjak SUI", b"You know what real extremism is? It's Chudjak standing his ground, no matter what the haters say! These elites only care about their own interests and leave us behind. All that open-minded and inclusive talk is straight-up BS! $Chudjak gets it  the world needs hardcore clarity, not some fake political correctness. We need action, not weak compromises. Facts!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_70c2c4d362.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUDJAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUDJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

