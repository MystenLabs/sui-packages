module 0x6fac140cf66c073cde5d30508a4ee46f4437a620e84f15362012721890bb85a5::koma {
    struct KOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMA>(arg0, 6, b"KOMA", b"Komari", b"Welcome to the $KOMA community, the most famous Shiba Inu on social media, ready to take the spotlight on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_Xa690_Pf_400x400_ee1294e329.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

