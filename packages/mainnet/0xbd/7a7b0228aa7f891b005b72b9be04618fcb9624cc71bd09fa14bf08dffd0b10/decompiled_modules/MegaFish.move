module 0xbd7a7b0228aa7f891b005b72b9be04618fcb9624cc71bd09fa14bf08dffd0b10::MegaFish {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<MEGAFISH>,
    }

    struct MEGAFISH has drop {
        minting_disabled: bool,
    }

    struct MegaFish has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<MEGAFISH>,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<MEGAFISH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 10 / 100;
        let v1 = arg1 - v0;
        let v2 = v1 * 80 / 100;
        assert!(v0 + v2 <= arg1, 0);
        0x2::coin::mint_and_transfer<MEGAFISH>(arg0, v2, 0x2::tx_context::sender(arg3), arg3);
        0x2::coin::mint_and_transfer<MEGAFISH>(arg0, v1 - v2, arg2, arg3);
    }

    fun init(arg0: MEGAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGAFISH>(arg0, 9, b"MEGAFISH", b"MEGAFISH", b"MegaFish is in the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/logo_cozcat_9c068db346.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEGAFISH>>(v1);
        0x2::coin::mint_and_transfer<MEGAFISH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGAFISH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

