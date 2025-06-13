module 0xce1454811ec7e64c7b8711325f10bcdffd4515aab78618b1c7e36680be430ed9::void {
    struct VOID has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOID>(arg0, 9, b"void", b"the void", b"enter the void", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeid27zqiarl4xwqffv4ns7aouacued4hqnxjtsnuogqs2e7bj5k3pi.ipfs.web3approved.com/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjaWQiOiJiYWZ5YmVpZDI3enFpYXJsNHh3cWZmdjRuczdhb3VhY3VlZDRocW54anRzbnVvZ3FzMmU3Ymo1azNwaSIsInByb2plY3RfdXVpZCI6IjgyMzRiZGZhLWE1N2YtNDk5Yy04NmFhLTcwZDYyOThjODNlZCIsImlhdCI6MTc0OTgyNTk4NCwic3ViIjoiSVBGUy10b2tlbiJ9.PxFZS7G3xuhSganlKa-NF-AIURR5Mu50hy1KpgoazIY")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<VOID>>(0x2::coin::mint<VOID>(&mut v2, 1000000000000000000, arg1), @0x2ba757c3a139bc667e16d8a8f0155fe24d666be8d9dcdb143178d0399c015999);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VOID>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOID>>(v1);
    }

    // decompiled from Move bytecode v6
}

