module 0x49649f6ec67e5a78f184b945c8b7e846c25f36316689906a48d0b13f3e664713::freezer {
    entry fun freeze_metadata(arg0: 0x2::coin::CoinMetadata<0xdb655997b5f7f3f7cbee38695a4fdf774c21f885b350af2232328fe93cf2c439::generis::GENERIS>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<0xdb655997b5f7f3f7cbee38695a4fdf774c21f885b350af2232328fe93cf2c439::generis::GENERIS>>(arg0);
    }

    // decompiled from Move bytecode v6
}

