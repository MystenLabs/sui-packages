module 0x712cbcc25f801b8262b3b51bd19efec7327055ce6f425401d7d5139760dea654::scf {
    struct SCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCF>(arg0, 9, b"SCF", b"Smoking Chicken Fish", x"436869636b656e69746869616e7320333a31342020e2809c48652077686f20686f6c6473207368616c6c20626520726963686572207468616e2068652077686f2068617320736f6c64e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/GiG7Hr61RVm4CSUxJmgiCoySFQtdiwxtqf64MsRppump.png?size=lg&key=543ef8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCF>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

