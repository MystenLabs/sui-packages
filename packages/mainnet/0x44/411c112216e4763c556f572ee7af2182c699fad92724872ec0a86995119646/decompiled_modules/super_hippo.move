module 0x44411c112216e4763c556f572ee7af2182c699fad92724872ec0a86995119646::super_hippo {
    struct SUPER_HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPER_HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPER_HIPPO>(arg0, 9, b"SUPER HIPPO", b"SUPER HIPPO", b"MAKE SUPPER HIPPO GREAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://thumbs.dreamstime.com/b/super-hero-hippo-stylized-movie-character-high-resolution-cartoon-animal-wearing-comic-book-superhero-cape-depicted-296845105.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPER_HIPPO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPER_HIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPER_HIPPO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

