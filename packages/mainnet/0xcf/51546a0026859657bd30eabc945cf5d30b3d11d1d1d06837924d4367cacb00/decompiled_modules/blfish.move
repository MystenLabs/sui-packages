module 0xcf51546a0026859657bd30eabc945cf5d30b3d11d1d1d06837924d4367cacb00::blfish {
    struct BLFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLFISH>(arg0, 6, b"BLFISH", b"BLACK FISH", b"The BLACK FISH ($BLFISH) project is a new initiative with the potential to reach new heights. Why is BLACK FISH safe, and why should you bet on the black fish? Find out more in our Telegram group and on our website. Join the project now, as the developer expects a listing in the official POOL after the MOVEPUMP stage ends!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fish_LOGO_95dd8a9f03.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

