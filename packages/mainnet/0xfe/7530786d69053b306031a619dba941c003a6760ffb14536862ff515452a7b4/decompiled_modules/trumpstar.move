module 0xfe7530786d69053b306031a619dba941c003a6760ffb14536862ff515452a7b4::trumpstar {
    struct TRUMPSTAR has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: 0x2::coin::Coin<TRUMPSTAR>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPSTAR>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: TRUMPSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSTAR>(arg0, 6, b"TRUMPSTAR", b"TRUMPS", b"$TRUMPS is the meme by itself and for the meme culture.To Create Trump and US Great Again  https://www.trumpstar.org/   https://x.com/trumpstarsui  https://t.me/trumpstarsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmW6HgCSNYqMnHR1m6nd1YNFt1kDFsqCdxqQyZ9dAdmyXw")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPSTAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSTAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: 0x2::coin::Coin<TRUMPSTAR>) : u64 {
        0x2::coin::burn<TRUMPSTAR>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<TRUMPSTAR>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TRUMPSTAR> {
        0x2::coin::mint<TRUMPSTAR>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

