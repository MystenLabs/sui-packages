module 0x8fc3458fc0fb29abd6c55479aef507f956808c58cf62d985bc5cd94e1d3f3303::monke {
    struct MONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKE>(arg0, 6, b"Monke", b"Monke Aptos", b"The king of the meme-jungle on #Aptos. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rkgn0_EZS_400x400_df1705d92b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

