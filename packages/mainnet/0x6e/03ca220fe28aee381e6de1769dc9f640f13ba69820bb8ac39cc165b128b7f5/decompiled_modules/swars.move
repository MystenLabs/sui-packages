module 0x6e03ca220fe28aee381e6de1769dc9f640f13ba69820bb8ac39cc165b128b7f5::swars {
    struct SWARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWARS>(arg0, 9, b"SWARS", b"SuiWars", b"In a galaxy oppressed by the Centralized Empire, the Sui Rebellion emerges, armed with the powerful Sui Protocol to challenge financial tyranny. As they battle the forces of Lord Fiatine and the dark enforcer Darth Ledger, the fight for decentralization becomes a race to restore freedom and balance to the galaxy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1798716266435297280/Wi1Syh54.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWARS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWARS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

