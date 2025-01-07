module 0xd5398e5cca454592184854305aeb86fdd79175505744cc3573a72686c5233dd3::bret {
    struct BRET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRET>, arg1: 0x2::coin::Coin<BRET>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRET>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRET>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRET>(arg0, 6, b"BRET SUI", b"BRET", b"The one and only OG $BRETT ON SUI 0x240..We are not an individual we are an ARMY!  https://x.com/brettether", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://harlequin-payable-basilisk-127.mypinata.cloud/ipfs/QmW8KbKJeRGGRShcUvUZEfP8oHZVNVENsQehrrndvnM81b")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRET>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BRET>, arg1: 0x2::coin::Coin<BRET>) : u64 {
        0x2::coin::burn<BRET>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BRET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BRET> {
        0x2::coin::mint<BRET>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

