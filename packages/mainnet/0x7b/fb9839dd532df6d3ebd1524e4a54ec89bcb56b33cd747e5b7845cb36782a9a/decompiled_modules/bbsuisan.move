module 0x7bfb9839dd532df6d3ebd1524e4a54ec89bcb56b33cd747e5b7845cb36782a9a::bbsuisan {
    struct BBSUISAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSUISAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSUISAN>(arg0, 6, b"Bbsuisan", b"Waveseers", x"477261636566756c2079657420617070726f61636861626c652c2077697468206120746f756368206f662068756d6f72207468617420656e64656172732068657220746f20616c6c2e0a0a4865722070726573656e6365207369676e616c732067726f7774682c206d756368206c696b652061206865616c7468792c207468726976696e67206f6365616e2065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737176841311.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBSUISAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSUISAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

