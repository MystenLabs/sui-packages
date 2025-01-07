module 0x2ddf37c38b60f4340adb23368671c42e2f2c52229288bff85fe8f7ffa8ebf60d::murkat {
    struct MURKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURKAT>(arg0, 6, b"MURKAT", b"murmewd kat", b"prep the porthole for imminent crypto riches as MURMEWD Kat surfaces with danker Aqua powers in SUI underwater world! This salty feline hero radiates pump energies so royal through his trident, even Aquaman cant compete! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114641_a8da5bc96c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

