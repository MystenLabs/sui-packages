module 0x305685b51b371ea002a9667dfc81c8e92a74c0b6e4ee74d7a02df67a5c36bc9b::gyara {
    struct GYARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYARA>(arg0, 9, b"GYARA", b"Gyara", x"477961726120284a6170616e6573653a20e382aee383a3e383a9204779617261292069732061204779617261646f73207468617420526564206f776e7320696e20506f6bc3a96d6f6e20416476656e747572657320616e642068697320736978746820506f6bc3a96d6f6e206f766572616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GYARA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYARA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

