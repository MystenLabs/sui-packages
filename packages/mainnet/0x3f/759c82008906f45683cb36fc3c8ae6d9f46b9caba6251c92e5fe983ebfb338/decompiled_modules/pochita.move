module 0x3f759c82008906f45683cb36fc3c8ae6d9f46b9caba6251c92e5fe983ebfb338::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: 0x2::coin::Coin<POCHITA>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POCHITA>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 6, b"Pochita Sui CTO", b"POCHITA", b"Pochita The New Cheems   https://x.com/pochitasuicto https://t.me/pochitasuicto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FAlbedo_Base_XL_a_person_swimming_freely_in_the_sea_only_blue_an_3_1_3_447be7b649.png&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: 0x2::coin::Coin<POCHITA>) : u64 {
        0x2::coin::burn<POCHITA>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<POCHITA>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POCHITA> {
        0x2::coin::mint<POCHITA>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

