module 0xfd928185caa02bd932da6819eb9b95c5672db5134c42ad2a823536a2c1870846::img {
    struct Img has store, key {
        id: 0x2::object::UID,
        alt: 0x1::option::Option<0x1::string::String>,
        crossorigin: 0x1::option::Option<0x1::string::String>,
        decoding: 0x1::option::Option<0x1::string::String>,
        height: 0x1::option::Option<u64>,
        ismap: bool,
        loading: 0x1::option::Option<0x1::string::String>,
        referrerpolicy: 0x1::option::Option<0x1::string::String>,
        sizes: vector<ImgSizesValue>,
        src: 0x1::string::String,
        srcset: vector<ImgSrcsetValue>,
        title: 0x1::option::Option<0x1::string::String>,
        usemap: 0x1::option::Option<0x1::string::String>,
        width: 0x1::option::Option<u64>,
    }

    struct ImgSrcsetValue has store {
        src: 0x1::string::String,
        width: u64,
    }

    struct ImgSizesValue has store {
        condition: 0x1::option::Option<0x1::string::String>,
        size: u64,
    }

    public fun add_create_img_sizes_value(arg0: ImgSizesValue, arg1: &mut Img) {
        0x1::vector::push_back<ImgSizesValue>(&mut arg1.sizes, arg0);
    }

    public fun add_create_img_srcset_value(arg0: ImgSrcsetValue, arg1: &mut Img) {
        0x1::vector::push_back<ImgSrcsetValue>(&mut arg1.srcset, arg0);
    }

    public fun create(arg0: 0x1::option::Option<0x1::string::String>, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<u64>, arg4: bool, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: 0x1::string::String, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x1::option::Option<0x1::string::String>, arg10: 0x1::option::Option<u64>, arg11: &mut 0x2::tx_context::TxContext) : Img {
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            let v0 = 0x1::vector::empty<0x1::string::String>();
            let v1 = &mut v0;
            0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"anonymous"));
            0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"use-credentials"));
            assert!(0x1::vector::contains<0x1::string::String>(&v0, 0x1::option::borrow<0x1::string::String>(&arg1)), 2);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            let v2 = 0x1::vector::empty<0x1::string::String>();
            let v3 = &mut v2;
            0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"async"));
            0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"sync"));
            assert!(0x1::vector::contains<0x1::string::String>(&v2, 0x1::option::borrow<0x1::string::String>(&arg2)), 3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            let v4 = 0x1::vector::empty<0x1::string::String>();
            let v5 = &mut v4;
            0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"auto"));
            0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"eager"));
            0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"lazy"));
            assert!(0x1::vector::contains<0x1::string::String>(&v4, 0x1::option::borrow<0x1::string::String>(&arg5)), 1);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            let v6 = 0x1::vector::empty<0x1::string::String>();
            let v7 = &mut v6;
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"no-referrer"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"no-referrer-when-downgrade"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"origin"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"origin-when-cross-origin"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"same-origin"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"strict-origin"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"strict-origin-when-cross-origin"));
            0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"unsafe-url"));
            assert!(0x1::vector::contains<0x1::string::String>(&v6, 0x1::option::borrow<0x1::string::String>(&arg6)), 3);
        };
        Img{
            id             : 0x2::object::new(arg11),
            alt            : arg0,
            crossorigin    : arg1,
            decoding       : arg2,
            height         : arg3,
            ismap          : arg4,
            loading        : arg5,
            referrerpolicy : arg6,
            sizes          : 0x1::vector::empty<ImgSizesValue>(),
            src            : arg7,
            srcset         : 0x1::vector::empty<ImgSrcsetValue>(),
            title          : arg8,
            usemap         : arg9,
            width          : arg10,
        }
    }

    public fun create_img_sizes_value(arg0: 0x1::option::Option<0x1::string::String>, arg1: u64) : ImgSizesValue {
        ImgSizesValue{
            condition : arg0,
            size      : arg1,
        }
    }

    public fun create_img_srcset_value(arg0: 0x1::string::String, arg1: u64) : ImgSrcsetValue {
        ImgSrcsetValue{
            src   : arg0,
            width : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

