module 0xb613fc81f1bb8db1685ecbaa2d0b89a03057a4833acebff0aab0f6316dbd5e4e::cover_art {
    struct CoverArt has copy, drop, store {
        still: 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData,
        animated: 0x1::option::Option<0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>,
    }

    public fun animated(arg0: &CoverArt) : &0x1::option::Option<0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData> {
        &arg0.animated
    }

    public fun new(arg0: 0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData, arg1: 0x1::option::Option<0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>) : CoverArt {
        0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::assert_is_blob(&arg0);
        if (0x1::option::is_some<0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(&arg1)) {
            0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::assert_is_blob(0x1::option::borrow<0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData>(&arg1));
        };
        CoverArt{
            still    : arg0,
            animated : arg1,
        }
    }

    public fun still(arg0: &CoverArt) : &0x87c196f475ea38ad3493daa600087a0203c3406a20ffd393aae23b801decbd10::walrus_data::WalrusData {
        &arg0.still
    }

    // decompiled from Move bytecode v7
}

