module 0x930364f793df057a0a43a68b947d4481b99959abbf74c05601c385ff1159ccb6::jobfree {
    struct JOBFREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOBFREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOBFREE>(arg0, 3, b"JOBFREE", b"JobFreeToken", b"- \"JobFreeToken Celebrating freedom from work!\" - \"No work, just fun with JobFreeToken!\" - \"Time to disconnect from work. Connect with JobFreeToken!\" - \"Work can wait. It's time for JobFreeToken!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FUntitled_design_3d93be1035.PNG&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOBFREE>(&mut v2, 150000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOBFREE>>(v2, @0x5c9bb147d9ed48100b208a900ab1f8777035fd303522c941d06d5fbc25d68021);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOBFREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

