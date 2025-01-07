module 0xd017ba0b72fc7422d7912023366ff80beaded3600a3f823be68a48ad3c0b4ac9::Kecson_Coin {
    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        owner: address,
    }

    struct KECSON_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KECSON_COIN>, arg1: 0x2::coin::Coin<KECSON_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BurnEvent{
            amount : 0x2::coin::burn<KECSON_COIN>(arg0, arg1),
            owner  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    fun init(arg0: KECSON_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KECSON_COIN>(arg0, 9, b"Kecson Coin", b"Task2 Kecson Coin", b"This is letsmove task2 Kecson Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KECSON_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KECSON_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KECSON_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KECSON_COIN>(arg0, arg1, arg2, arg3);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

