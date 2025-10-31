module 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::nft {
    struct MemeNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        walrus_file_id: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        blob: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob,
        blob_funds: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        parent_hierarchy: vector<0x2::object::ID>,
        children: vector<0x2::object::ID>,
        image_url: 0x1::string::String,
        likes: u64,
        liked_by: 0x2::table::Table<address, bool>,
        total_tip_amount: u64,
        created_at: u64,
    }

    public(friend) fun add_liker(arg0: &mut MemeNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, bool>(&mut arg0.liked_by, arg1, true);
    }

    public(friend) fun add_tip_amount(arg0: &mut MemeNFT, arg1: u64) {
        arg0.total_tip_amount = arg0.total_tip_amount + arg1;
    }

    public fun blob(arg0: &MemeNFT) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &arg0.blob
    }

    public fun blob_funds_value(arg0: &MemeNFT) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.blob_funds)
    }

    public(friend) fun blob_mut(arg0: &mut MemeNFT) : &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &mut arg0.blob
    }

    public fun children(arg0: &MemeNFT) : &vector<0x2::object::ID> {
        &arg0.children
    }

    entry fun create_meme(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        create_meme_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun create_meme_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::new(arg6);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = MemeNFT{
            id               : v1,
            title            : 0x1::string::utf8(arg0),
            description      : 0x1::string::utf8(arg1),
            walrus_file_id   : 0x1::string::utf8(arg2),
            walrus_blob_id   : 0x1::string::utf8(arg3),
            blob             : arg4,
            blob_funds       : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            parent_hierarchy : 0x1::vector::empty<0x2::object::ID>(),
            children         : 0x1::vector::empty<0x2::object::ID>(),
            image_url        : 0x1::string::utf8(arg5),
            likes            : 0,
            liked_by         : 0x2::table::new<address, bool>(arg6),
            total_tip_amount : 0,
            created_at       : 0x2::tx_context::epoch(arg6),
        };
        let v4 = 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::capability::new_creator_cap(v2, arg6);
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_meme_nft_created(v2, v0, v3.title, 0x1::option::none<0x2::object::ID>(), 0x2::tx_context::epoch(arg6));
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_creator_cap_created(0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::capability::CreatorCap>(&v4), v2);
        0x2::transfer::share_object<MemeNFT>(v3);
        0x2::transfer::public_transfer<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::capability::CreatorCap>(v4, v0);
    }

    entry fun create_remix(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: vector<u8>, arg6: &mut MemeNFT, arg7: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg8: &mut 0x2::tx_context::TxContext) {
        create_remix_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    fun create_remix_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: vector<u8>, arg6: &mut MemeNFT, arg7: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg7) < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg6.blob), 4);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_inner(&v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg6.children, v2);
        let v3 = 0x2::object::id<MemeNFT>(arg6);
        let v4 = &arg6.parent_hierarchy;
        assert!(0x1::vector::length<0x2::object::ID>(v4) + 1 < 6, 3);
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v5, v3);
        let v6 = 0x1::vector::length<0x2::object::ID>(v4);
        let v7 = if (v6 > 6 - 1) {
            6 - 1
        } else {
            v6
        };
        let v8 = 0;
        while (v8 < v7) {
            0x1::vector::push_back<0x2::object::ID>(&mut v5, *0x1::vector::borrow<0x2::object::ID>(v4, v8));
            v8 = v8 + 1;
        };
        let v9 = MemeNFT{
            id               : v1,
            title            : 0x1::string::utf8(arg0),
            description      : 0x1::string::utf8(arg1),
            walrus_file_id   : 0x1::string::utf8(arg2),
            walrus_blob_id   : 0x1::string::utf8(arg3),
            blob             : arg4,
            blob_funds       : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            parent_hierarchy : v5,
            children         : 0x1::vector::empty<0x2::object::ID>(),
            image_url        : 0x1::string::utf8(arg5),
            likes            : 0,
            liked_by         : 0x2::table::new<address, bool>(arg8),
            total_tip_amount : 0,
            created_at       : 0x2::tx_context::epoch(arg8),
        };
        let v10 = 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::capability::new_creator_cap(v2, arg8);
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_meme_nft_created(v2, v0, v9.title, 0x1::option::some<0x2::object::ID>(v3), 0x2::tx_context::epoch(arg8));
        0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::meme_events::emit_creator_cap_created(0x2::object::id<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::capability::CreatorCap>(&v10), v2);
        0x2::transfer::share_object<MemeNFT>(v9);
        0x2::transfer::public_transfer<0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::capability::CreatorCap>(v10, v0);
    }

    public fun created_at(arg0: &MemeNFT) : u64 {
        arg0.created_at
    }

    public fun description(arg0: &MemeNFT) : 0x1::string::String {
        arg0.description
    }

    public(friend) fun extend_blob(arg0: &mut MemeNFT, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.blob_funds), arg3);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, &mut arg0.blob, arg2, &mut v0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.blob_funds, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0));
    }

    public fun extend_blob_public(arg0: &mut MemeNFT, arg1: &0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::admin::ExtendConfig, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x61ef678e5640ae93e0cdd8ceff31d62279877d8fa39e3f32b4e7cf9314862e9c::admin::get_extend_reward(arg1);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.blob_funds) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.blob_funds, v0), arg4), 0x2::tx_context::sender(arg4));
        };
        extend_blob(arg0, arg2, arg3, arg4);
    }

    public(friend) fun extract_blob_funds(arg0: &mut MemeNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.blob_funds, arg1), arg2)
    }

    public(friend) fun fund_blob(arg0: &mut MemeNFT, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.blob_funds, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public(friend) fun get_uid_mut(arg0: &mut MemeNFT) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun image_url(arg0: &MemeNFT) : 0x1::string::String {
        arg0.image_url
    }

    public(friend) fun increment_likes(arg0: &mut MemeNFT) {
        arg0.likes = arg0.likes + 1;
    }

    public(friend) fun is_liked_by(arg0: &MemeNFT, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.liked_by, arg1)
    }

    public fun likes(arg0: &MemeNFT) : u64 {
        arg0.likes
    }

    public fun parent_hierarchy(arg0: &MemeNFT) : &vector<0x2::object::ID> {
        &arg0.parent_hierarchy
    }

    public fun title(arg0: &MemeNFT) : 0x1::string::String {
        arg0.title
    }

    public fun total_tip_amount(arg0: &MemeNFT) : u64 {
        arg0.total_tip_amount
    }

    public fun walrus_blob_id(arg0: &MemeNFT) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    public fun walrus_file_id(arg0: &MemeNFT) : 0x1::string::String {
        arg0.walrus_file_id
    }

    // decompiled from Move bytecode v6
}

