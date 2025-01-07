module 0xe66aead38d17efd7fa41d3d30d3059a061de8947dde2289de8e3040cb9b00780::brump {
    struct BRUMP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRUMP>, arg1: 0x2::coin::Coin<BRUMP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRUMP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRUMP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUMP>(arg0, 6, b"BRUMP", b"Brett Trump", b"$Brump, the revolutionary memecoin      https://www.brump.fun/   https://x.com/brumpsui  https://t.me/brump_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmVKmwe9zYnJHi25pcBqAr3i97UxYE8HxeGguFjpPM3EW8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BRUMP>, arg1: 0x2::coin::Coin<BRUMP>) : u64 {
        0x2::coin::burn<BRUMP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BRUMP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BRUMP> {
        0x2::coin::mint<BRUMP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

