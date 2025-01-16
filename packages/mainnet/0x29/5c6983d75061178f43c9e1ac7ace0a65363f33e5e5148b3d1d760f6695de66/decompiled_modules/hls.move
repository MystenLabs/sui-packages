module 0x295c6983d75061178f43c9e1ac7ace0a65363f33e5e5148b3d1d760f6695de66::hls {
    struct HLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLS>(arg0, 9, b"HLS", b"HO LEE SHEET", b"Holy moly !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a14cf27eda468c08a385d699d9a34895blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

