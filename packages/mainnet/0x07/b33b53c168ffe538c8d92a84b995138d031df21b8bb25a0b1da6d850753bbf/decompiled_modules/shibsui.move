module 0x7b33b53c168ffe538c8d92a84b995138d031df21b8bb25a0b1da6d850753bbf::shibsui {
    struct SHIBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBSUI>(arg0, 6, b"ShibSui", b"ShibaSui", b"Introducing ShibaSui, the next big thing in the meme coin world! Get ready to be part of something huge from the very beginning. ShibaSui is still in the works, but the foundation is being built for massive growth, and those getting in early are positioned to reap the rewards as first investors. With the development team holding just 5% of the total supply, were ensuring this project is community-driven and built for the people. Now's your chance to join the ShibaSui revolution before it takes off. Don't miss out on this massive opportunity!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/shibsui_138bdafab9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

