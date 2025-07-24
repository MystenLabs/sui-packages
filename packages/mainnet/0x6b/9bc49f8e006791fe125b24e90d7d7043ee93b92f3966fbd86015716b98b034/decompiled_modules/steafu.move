module 0x6b9bc49f8e006791fe125b24e90d7d7043ee93b92f3966fbd86015716b98b034::steafu {
    struct STEAFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEAFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<STEAFU>(arg0, 9, b"STEAFU", b"test again", b"shut the fuck up", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRqgDAABXRUJQVlA4IJwDAABwGACdASqAAIAAPm0ylEakIyIhLRzoOIANiUAa3EAr882P1HLu+C/ZcpbQB/mejTzO/7ge57oRv8B7QvobdLf/mMll8j9in9wrqv7X4MG6Kxk3e23levzRpeiLpFTVSh6nafe1vJ17Gxhdqv/7kgektXBk+qX2qDrvYqawSgFQCFxUvVq7sw7Umyac9RwdtZme8AeRchsX7yQm6T9gy/qe82s5hvUR2aftpq7NMzKxwe7n1lHPvSsJOCE6FfuP20BezQx3DM1dIlD2rJAA/vdrq6PURbf/yhHoD6A85qxGBHKyACNIbwtSlHjLaymSmZm8xSGP3Ld7O5MWGwx3i2/lIdThSYnEYc2mfM+dRLnQGwx0zf8cF1cqeRfoDLz+OvlvvZJfs7iKwI4sVjyOaXCYP6BCu9RWcu6BWDGq8E1+uSgxZ0WAoAXrm8Rp6ecwYBq+lGeaefc3JXzmLAi3S4Q69f8BC0dLv+c2K3gt+LxzHexQZzcaxQjb1l6UEvzorPlqcjykca5408genT6ur7XwG+IaSyhferSeT5IEI1X93u3vCUmpmAIe1PtJ4j4V02Wg+tH+Y8t2jbAld3yEYlBtyP4PZrUMK9UcoimziE0IqhMzWZQWe4awxmyu4X+z65H5Ck+Fr/AUuH31j1vhCWvhMzSStf5caTB9rwYJyd/czZzWpkj/zjlrsexrGI/dcVy81WpnUsm3nb+08hu9INyqjDAadgAKpyE6lqe+RO8dOoEUfyMYH7unG3HFvQe6ZDCl0nWSRvMV47FDXm1FcgDUEq/FymsJ+iTZODrwYJy/7kjnBJPf+ZSxaPfnbBYZrb3dvf1cP6W0XFOc56fRXHVaEz+xGoQUFle3xrI0xfbwyihQD1e7eShkq3IgGvt2v08Dx1J09J5tZoqKNZsBO6m+6+Hhpb4yctzyY+JS76/dLk0pJsDHJwhsS+pFdQc5mZk44OOfaXiT+oRNrcwdQN8Dpsf+lYE/p5bBM8yvR72M9VOPCa9XkNBO3xzQGMgMT/5iEgL8sYeAY95IM7zRZcYR+thDoGgfZKIKrRhXlh9XCRnTs/0ZItDDCzeQpQyJ3p3UvbE3pv/wflZdtCjw4gyFCnyN+06GnXcttWZhc9/T3QPwqVBJGi54qvdYT1fRLgMaRsvGblAz+UUQarp7cwX6B+qxUZZb0BZvrIlwLLFR2aHxqM7n65ExCLOOu4AKnxT2yQhkrOFqQAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEAFU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEAFU>>(v1);
    }

    // decompiled from Move bytecode v6
}

