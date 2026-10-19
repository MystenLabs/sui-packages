module 0xd148e9f8011adb5305a7365b920219d42082e4a5bd61a292febb703e48861686::parchment {
    struct PARCHMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARCHMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARCHMENT>(arg0, 9, b"PARCHMENT", b"PARCHMENT", b"Freely transferable. Not collateral.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARCHMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARCHMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun install_treasury<T0>(arg0: &mut 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>, arg1: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::config::Config, arg2: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::AuthorityCap<0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::PACKAGE, 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::authority::ADMIN>, arg3: 0x2::coin::TreasuryCap<PARCHMENT>) {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::install_reward_cap<T0, PARCHMENT>(arg0, arg1, arg2, arg3);
    }

    public fun supply<T0>(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::Exchange<T0>) : u64 {
        0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::exchange::reward_supply<T0, PARCHMENT>(arg0)
    }

    // decompiled from Move bytecode v7
}

