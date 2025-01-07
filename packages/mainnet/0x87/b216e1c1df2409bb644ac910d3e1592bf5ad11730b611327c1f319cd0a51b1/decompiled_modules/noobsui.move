module 0x87b216e1c1df2409bb644ac910d3e1592bf5ad11730b611327c1f319cd0a51b1::noobsui {
    struct NOOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOOBSUI>(arg0, 9, b"NOOBSUI", b"Noobsui", b"Explore the Creative world of Sui together ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwallpapers.com%2Froblox-noob&psig=AOvVaw2ZFwyoluZVNUhf5QsVkg-n&ust=1707057350301000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCPCvtKmyj4QDFQAAAAAdAAAAABAF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOOBSUI>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOOBSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

