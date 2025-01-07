module 0xb75dbe6f3a64163d35e998deb85720e85d1048398a8ac955883f7014911aa111::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIM>, arg1: 0x2::coin::Coin<SUIM>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIM>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIM>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"Suim", b"SUIM", b"sui suims best The most unique trait shared by both swimming and the Sui blockchain is efficiency in parallelism. Just as swimmers use their arms and legs simultaneously for maximum speed, Sui leverages its object-centric model to process transactions in parallel, without requiring global  https://www.suim.cloud/  https://x.com/suimofficial  https://t.me/suimschannel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FAlbedo_Base_XL_a_person_swimming_freely_in_the_sea_only_blue_an_3_1_3_447be7b649.png&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIM>, arg1: 0x2::coin::Coin<SUIM>) : u64 {
        0x2::coin::burn<SUIM>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUIM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUIM> {
        0x2::coin::mint<SUIM>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

