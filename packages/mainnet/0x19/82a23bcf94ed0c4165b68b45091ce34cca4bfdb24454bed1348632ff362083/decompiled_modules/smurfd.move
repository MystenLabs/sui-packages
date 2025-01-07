module 0x1982a23bcf94ed0c4165b68b45091ce34cca4bfdb24454bed1348632ff362083::smurfd {
    struct SMURFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFD>(arg0, 6, b"SmurfD", b"SmurfPet", b"The smurf dog is here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zo_Q_Bg_NQHS_Ran3_Lslqzg_C_Ow_eb9a4a949e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

