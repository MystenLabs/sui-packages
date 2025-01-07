module 0xf1e943130f1f38fb18c0a0b637379ea6fa076dcd8445e86a06aba30833ac6fe5::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"Aqua The Coin - CTO", b"Hi, welcome all to $AQUA, I see the Aqua coin project on SUI is very good and has a very good narrative, but some nigga ruined it with just a little bit of money, now I will Lead CTO of this project. And I will be the one to pay for the project without any money from the community. Pay trending Pay dex CMC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7f391572_6446_4419_996b_57d53964088b_eb8cde2867.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

