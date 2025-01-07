module 0x674c4ef682300bc14ca1a8436e58d22096c2695f019c365d6a438fac9f875bda::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BANANA>, arg1: 0x2::coin::Coin<BANANA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BANANA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BANANA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 6, b"BANANA", b"Banana coin", b"Your Daily dose of potassium on Sui Blockchain. Experimental Meme Coin, No Social, Fixed Cap, 100% LP Locked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/free-vector/sticker-design-with-banana-isolated_1308-77292.jpg?w=740&t=st=1692327585~exp=1692328185~hmac=4e55607eb11267f45ad5c21050155072a1ea812f8e21cff456260214121f13dd")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BANANA>, arg1: 0x2::coin::Coin<BANANA>) : u64 {
        0x2::coin::burn<BANANA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BANANA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BANANA> {
        0x2::coin::mint<BANANA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

