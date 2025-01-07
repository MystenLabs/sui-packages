module 0xc9e510094f0c931dc81d62aaa48fb2f200f5827b20717204a96e013a8237fc06::caw {
    struct CAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAW>(arg0, 9, b"CAW", b"Hello world", b"CAW CAW CAW CAW CAW CAW CAW CAW CAW CAW CAW CAW CAW CAW CAW CAWCAW CAW CAW CAW CAW CAW CAW CAWCAW CAW CAW CAW CAW CAW CAW CAWCAW CAW CAW CAW CAW CAW CAW CAWCAW CAW CAW CAW CAW CAW CAW CAWCAW CAW CAW CAW CAW CAW CAW CAW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/12b2391576953ea424b3a3eca5fa5123blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

