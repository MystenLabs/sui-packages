module 0xe670a2919445e0766fdd5eb8d775d816b8e3c536bb281c32993c53e6074b31da::kuvainu {
    struct KUVAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUVAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUVAINU>(arg0, 6, b"KUVAINU", b"Kuva Inu Sui", b"Kuva Inu is a cryptocurrency project inspired by the noble and majestic traits of the Kuvasz dog breed, blended with the playful spirit of meme culture embodied by Doge and Shiba Inu.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250107_022145_763_88be98d789.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUVAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUVAINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

