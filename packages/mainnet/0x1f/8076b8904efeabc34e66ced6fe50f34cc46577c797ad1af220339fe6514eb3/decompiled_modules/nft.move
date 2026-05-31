module 0xc590761e7ff3ec30c719075fe0142c42ff75860d9b500de6c0c0416c0bc4ed51::nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_blob_id: 0x1::string::String,
        quilt_patch_id: 0x1::string::String,
        file_name: 0x1::string::String,
        thumbnail_blob_id: 0x1::string::String,
        thumbnail_quilt_patch_id: 0x1::string::String,
        thumbnail_file_name: 0x1::string::String,
        media_type: 0x1::string::String,
        created_at: u64,
        file_hash: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Minted has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        image_blob_id: 0x1::string::String,
        quilt_patch_id: 0x1::string::String,
        file_name: 0x1::string::String,
        thumbnail_blob_id: 0x1::string::String,
        thumbnail_quilt_patch_id: 0x1::string::String,
        thumbnail_file_name: 0x1::string::String,
        media_type: 0x1::string::String,
        file_hash: 0x1::string::String,
        created_at: u64,
    }

    struct MediaRefsRepaired has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        quilt_patch_id: 0x1::string::String,
        file_name: 0x1::string::String,
        thumbnail_quilt_patch_id: 0x1::string::String,
        thumbnail_file_name: 0x1::string::String,
    }

    public fun id(arg0: &NFT) : 0x2::object::ID {
        0x2::object::id<NFT>(arg0)
    }

    public fun created_at(arg0: &NFT) : u64 {
        arg0.created_at
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    public fun file_hash(arg0: &NFT) : &0x1::string::String {
        &arg0.file_hash
    }

    public fun file_name(arg0: &NFT) : &0x1::string::String {
        &arg0.file_name
    }

    public fun image_blob_id(arg0: &NFT) : &0x1::string::String {
        &arg0.image_blob_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun init_once(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun media_type(arg0: &NFT) : &0x1::string::String {
        &arg0.media_type
    }

    entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = NFT{
            id                       : 0x2::object::new(arg11),
            name                     : 0x1::string::utf8(arg0),
            description              : 0x1::string::utf8(arg1),
            image_blob_id            : 0x1::string::utf8(arg2),
            quilt_patch_id           : 0x1::string::utf8(arg3),
            file_name                : 0x1::string::utf8(arg4),
            thumbnail_blob_id        : 0x1::string::utf8(arg5),
            thumbnail_quilt_patch_id : 0x1::string::utf8(arg6),
            thumbnail_file_name      : 0x1::string::utf8(arg7),
            media_type               : 0x1::string::utf8(arg8),
            created_at               : v0,
            file_hash                : 0x1::string::utf8(arg9),
        };
        let v2 = 0x2::tx_context::sender(arg11);
        let v3 = Minted{
            object_id                : 0x2::object::id<NFT>(&v1),
            owner                    : v2,
            image_blob_id            : v1.image_blob_id,
            quilt_patch_id           : v1.quilt_patch_id,
            file_name                : v1.file_name,
            thumbnail_blob_id        : v1.thumbnail_blob_id,
            thumbnail_quilt_patch_id : v1.thumbnail_quilt_patch_id,
            thumbnail_file_name      : v1.thumbnail_file_name,
            media_type               : v1.media_type,
            file_hash                : v1.file_hash,
            created_at               : v0,
        };
        0x2::event::emit<Minted>(v3);
        0x2::transfer::transfer<NFT>(v1, v2);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public fun quilt_patch_id(arg0: &NFT) : &0x1::string::String {
        &arg0.quilt_patch_id
    }

    entry fun repair_media_refs(arg0: &mut NFT, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        arg0.quilt_patch_id = 0x1::string::utf8(arg1);
        arg0.file_name = 0x1::string::utf8(arg2);
        arg0.thumbnail_quilt_patch_id = 0x1::string::utf8(arg3);
        arg0.thumbnail_file_name = 0x1::string::utf8(arg4);
        let v0 = MediaRefsRepaired{
            object_id                : 0x2::object::id<NFT>(arg0),
            owner                    : 0x2::tx_context::sender(arg5),
            quilt_patch_id           : arg0.quilt_patch_id,
            file_name                : arg0.file_name,
            thumbnail_quilt_patch_id : arg0.thumbnail_quilt_patch_id,
            thumbnail_file_name      : arg0.thumbnail_file_name,
        };
        0x2::event::emit<MediaRefsRepaired>(v0);
    }

    public fun thumbnail_blob_id(arg0: &NFT) : &0x1::string::String {
        &arg0.thumbnail_blob_id
    }

    public fun thumbnail_file_name(arg0: &NFT) : &0x1::string::String {
        &arg0.thumbnail_file_name
    }

    public fun thumbnail_quilt_patch_id(arg0: &NFT) : &0x1::string::String {
        &arg0.thumbnail_quilt_patch_id
    }

    // decompiled from Move bytecode v7
}

