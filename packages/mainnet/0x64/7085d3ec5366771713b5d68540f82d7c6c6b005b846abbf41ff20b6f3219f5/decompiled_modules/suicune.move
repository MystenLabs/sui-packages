module 0x647085d3ec5366771713b5d68540f82d7c6c6b005b846abbf41ff20b6f3219f5::suicune {
    struct SUICUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUNE>(arg0, 6, b"Suicune", b"SUicune", b"The legendary guardian of the $Sui ecosystem, $suicune will only be held by those who are worthy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicune_19450bd13f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

