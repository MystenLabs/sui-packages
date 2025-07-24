module 0xde5d4892fc2f7c83f6513f9ee1d4c0bd58d924e50970212070e03b4cd16070b6::egh {
    struct EGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<EGH>(arg0, 6, b"EGH", b"EggplantHub", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRmYEAABXRUJQVlA4IFoEAADQGgCdASqAAIAAPm0ylkckIyIhKJWqOIANiWcG+ByM0iTqYWf91T7MuS3quflrS34cY/OFgt5wYrf9cU8/edbn3Z3rejj9N9Q0Z0Qf0588eY57Kl5kXjpFAnhCvVtueW8ObOrNrOxNpla7gj3tLfi0I7DOyNeaX+XdIWmSYu/q+xOZZz1LwtJwNQbh861wI7IexBVnfzt63dBDyCoCj1C7CVgwOUubXA8PWRxKT0k7/Lmjnu7C6w+sNaZzv2Y807Mw6u9RkUHsOL8wFaFq31uJpf7H12ThqyOsQaW0qFJgAP754jNuJG4Qx3uSGhmvNoK/mUq+h3vzrj8M43UVpslaLslvuX6mxVZcgC9Ic++Oo544Ju344YbsNzfYxH+R4Un7hZ/+cLmeVKceT0+YUQ6IdPOgvWdDHf97YjHtPV+5ungzNdY+kzExFBjkX0Vmycb8YF41IQZb1zcs9h4c9FYXNLj5T/xBC83j7kJe1Xjx4t1exN3GwXiThQ8M2eo4GiVDRKai9BOcYLJSrODfuD8iM2NfvIviRrhFpbCG7dIvItlX+q3lXt6uzx/I6vO3HJ//ybaHwZ9xfwC5MoBGsgMMq9JZmf94898fCPv1YnW/nVgQKYaf41Y2hHr0PkDDCdo7HHX7tDV90a8mzAsz6PRAwPe9xEy8ksX/998BbnTNEVAlsPXt3UlrH7icT7x7TdRFp7LN3KdWf6E4AH2uwxWatVhrTW3soMv2w0LIYm44AZfPo/lK1PkmlwRSyA/mg/X4jdaiJKEID3f3fy9idlfnOUGU9zjU4wczUlvmMX8bANT9kMfxOoTf2fy7FN04PtMjGjot3iCGZebIpQW0IG6UB8H6F7aPYzZ/3iqHi36cKSCwbWXXMLjw20TG+NrX7a7uGDMjYp4p42tKv7uB8m5e9oFbwKu35G9aeaPfiSpLzYaT+mOap5wuP2D9FBgS1fHVmnM2wh9OJxp1NIBfET5HRgDG0GvHa6OAK2WknJJgo+D9sOXt/SdKnSWK4IETQPjyNjWocUL08CI85Sw/C1ex6JYMAqlDfXK0V3o61P2AS9mW4PNDYdBzK6UV6nnoi3KV9FzfttyyNm+8btaYxmgFn8v02/5fgZdE2rGMYsuNVVCRY2tonCKTOEYMiy+OLVEq/rSqIavpCimmkkd9SmxkFUSM3Xi8S8ckfhKDf+VYMmUcZZw+Q/3K4OmeHnd3O7NRsXLe7nJ60jUgoHWAE5JeoE5z5bF4pP5kacbgEWg9JJoewTemUTgY7TcTj2BgjPki3BDvJQgWjBsema4SM+pXhPR9yGKKVvIPdc1u/wrBRNnRSMM7O3PJNANbjS//0cMkXe/E67Er8fzvcMMtsy+6b9ReyvSr8XN4dzemDp3EUR1d/xd7H+K0HYsFdkVEmz+gK85SWR50xk8CjlFmxvZqu3PDGMcHWKDwGEhP0KVk1p3abjNQfEYC+pIrwd5zsZKuf2AO6IMAEAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

