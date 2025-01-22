module 0x6e9eba42397e9e349f9c95df374b7c3e2be65b1683f613362e00d12a4dfda7f2::bduck {
    struct BDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDUCK>(arg0, 6, b"BDUCK", b"Based Duck", b"While the haters are still flapping around in the kiddie pool, Based Duck is out here making it rain bread crumbs and stealing your girl. Why? Because he`s Based Duck-and nobody can quack at his level", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/123123_removebg_preview_34cd1d9e42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

