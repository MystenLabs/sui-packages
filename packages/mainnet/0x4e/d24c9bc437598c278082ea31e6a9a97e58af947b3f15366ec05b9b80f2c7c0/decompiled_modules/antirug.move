module 0x4ed24c9bc437598c278082ea31e6a9a97e58af947b3f15366ec05b9b80f2c7c0::antirug {
    struct ANTIRUG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ANTIRUG>, arg1: 0x2::coin::Coin<ANTIRUG>) {
        0x2::coin::burn<ANTIRUG>(arg0, arg1);
    }

    fun init(arg0: ANTIRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTIRUG>(arg0, 6, b"ANTIRUG", b"Say No To RUG", b"just make it 1000% or more, Fuck to All Ruggers, Buy on bluemove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/CnMN01P/norug.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANTIRUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTIRUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ANTIRUG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ANTIRUG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

