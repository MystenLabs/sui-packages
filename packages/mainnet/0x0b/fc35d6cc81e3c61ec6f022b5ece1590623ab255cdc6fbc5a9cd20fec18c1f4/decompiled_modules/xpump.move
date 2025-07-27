module 0xbfc35d6cc81e3c61ec6f022b5ece1590623ab255cdc6fbc5a9cd20fec18c1f4::xpump {
    struct XPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<XPUMP>(arg0, 6, b"XPUMP", b"xPump.fun", b"Not for the weak hearted", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkgDAABXRUJQVlA4IDwDAAAwGACdASqAAIAAPm0ykkakJaGhLJKaQLANiWkAKMA4ADwQPgzqU+yOmGfEBh4fRI0VIEmrUjN/ynq007eHuHep+6+Qm4G+6XCsYpwWOW5wiwzKIr5GmUl+5k2TbUlBBOJGJz83jdaCTZMK+ZXhiyC+6+n0nE6XDc5IetVl4q91IwK0EYZwoqTNyl5APAXdrklR5rLH5JzvdoDt2hLJwoFhcdGxL6j9/F4mccl8gvn+WFVBZksl/tk8Huoai3CgD7lZm6zSiFvG/fYQAP77nMBgr7fcw1RNkgfl8smy87llp+Ad+77rq0vqqdnfblhD96aIbMAkH/8cx4dp7ZL9acAvzLA1DfCnvH9Rf/6FLt9xFNs7MoFx8z1udiiQJuVnKK7GjVuHTw3W+qT2jGRKOCE/obXAZ+Jn0AO/6nP+2+eVkM9giSDFhGWp1sEkyoVZni+Dx8W+ZilbeJi+sd4ioBIwfEea63pIrgnah97ln/UwihkBTr8adgmIMdZ/ljUVV43p4n05WVRt0gJePl/moz+PFU2rjWgiAY0e1haKMJ1CFHJg5utBPSVmhXowViYPgi7UK+8nyA+vfha8tif9V9kr+g6baOlkbD/tLsyLT9EZllVy8BRO3DA/YCWTrHQXlQ2PcXdsMT8Hn3qNGY36ld9dNSVDdeK3WBucIKeKXYZ1nnLWQmo4aElptayCEkBp6mDSMIeLtgfiE2W87VLJwHo4xe5jvjKCf/G9ectZCajhoS5bmSK5CoqM/4bH+4e2O67p2nrz7lzs7Rb+Dny1zggef3/m89vhWT63HWmWm4X+koQaAeKPbd0Udb6qV70GmhqzcqtSkir/xcEpvxieir7fgbwhjXABXoRTESGqs8C0cdytpn/M2fy97m1R//ByvTH1u72FqsMigwK3xXonO1LjODZ2jQqyTnYaerFHkw4BrLTm2/W/kZHqJ1jJ+dI91cVCpWXTi6f3nh2mIiQEUKgrmFhrlAjVRkbf0uBvOjCZfmHe6v+rtBx4v8EF42CMzX7KxLuxjlgCnNs2N16XFPwmspYM0Xyo2ORN4t78q+fJ5+0spIl+EoTKV2xpZnlzi08ai3TAjtJiAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

