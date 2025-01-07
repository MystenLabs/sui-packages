module 0xa1ff865eda64a5d02a81d67b0f829bdb1a964d300b4ba978a1001aecd8b0dedf::paw {
    struct PAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAW>(arg0, 9, b"SSSPAW", b"PawSui", b"Pawsui is the cutest paw on the SUI network. This pussy cat comes with its own dapp for presale.The creators of this token, FOMO Factory, have repeatedly broken records on other chains for fastest sales.Now, it's turn for the SUI network to enjoy skillful development, beautiful art and an exceptional community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/sadhellkill/PawSui-images/refs/heads/main/logoaqua.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PAW>>(0x2::coin::mint<PAW>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PAW>>(v2);
    }

    // decompiled from Move bytecode v6
}

