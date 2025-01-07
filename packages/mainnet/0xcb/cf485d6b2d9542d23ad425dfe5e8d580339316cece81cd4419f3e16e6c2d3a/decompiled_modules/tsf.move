module 0xcbcf485d6b2d9542d23ad425dfe5e8d580339316cece81cd4419f3e16e6c2d3a::tsf {
    struct TSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSF>(arg0, 6, b"TSF", b"Travis Scott Fish", b"For degens who like memecoins and rap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/travis_scott_fish_8ac83dc829b62e94f4ee66ed86da793f_meme_e8a2e15d0d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

