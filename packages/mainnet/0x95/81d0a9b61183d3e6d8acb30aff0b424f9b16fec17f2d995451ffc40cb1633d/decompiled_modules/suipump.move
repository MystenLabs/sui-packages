module 0x9581d0a9b61183d3e6d8acb30aff0b424f9b16fec17f2d995451ffc40cb1633d::suipump {
    struct SUIPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(x"03534342075361636162616d6e5361636162616d732066756c6c206e616d65206973205361636162616d6261737069732c2077686963682077617320696e73706972656420627920616e20657874696e6374206a61776c65737320666973682066726f6d20746865204f72646f76696369616e20706572696f642e6268747470733a2f2f696d672e62677374617469632e636f6d2f6d756c74694c616e672f696d6167652f736f6369616c2f3830353539346434663934343130386339366466333366386566313964626539313732383338363535343336312e6a706567");
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 0);
        let (v2, v3) = 0x2::coin::create_currency<SUIPUMP>(arg0, 6, 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_vec_u8(&mut v0), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(0x2::bcs::peel_vec_u8(&mut v0))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMP>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

