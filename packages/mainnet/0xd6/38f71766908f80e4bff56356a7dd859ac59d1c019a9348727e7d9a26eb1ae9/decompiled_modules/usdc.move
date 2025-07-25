module 0xd638f71766908f80e4bff56356a7dd859ac59d1c019a9348727e7d9a26eb1ae9::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<USDC>,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC", b"USDC is a US dollar-backed stablecoin issued by Circle. USDC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::coin::mint_and_transfer<USDC>(&mut v2, 226600000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = MintCap{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        0x2::transfer::share_object<MintCap>(v3);
    }

    public entry fun mint(arg0: &mut MintCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDC>(&mut arg0.treasury, 1000000000, 0x2::tx_context::sender(arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

