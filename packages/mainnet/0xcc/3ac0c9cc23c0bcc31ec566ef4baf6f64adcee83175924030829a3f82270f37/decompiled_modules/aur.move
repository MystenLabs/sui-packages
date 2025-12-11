module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::aur {
    struct AUR has drop {
        dummy_field: bool,
    }

    public(friend) fun burn_internal(arg0: &mut 0x2::coin::TreasuryCap<AUR>, arg1: 0x2::coin::Coin<AUR>) {
        0x2::coin::burn<AUR>(arg0, arg1);
    }

    fun init(arg0: AUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUR>(arg0, 9, b"AUR", b"AURUM", b"The Sui-native, hard-capped, fair-launched Store-of-Value asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aur.supply/aur.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_internal(arg0: &mut 0x2::coin::TreasuryCap<AUR>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AUR> {
        0x2::coin::mint<AUR>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

